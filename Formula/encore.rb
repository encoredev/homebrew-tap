class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.8"
    checksums = {
        "darwin_arm64" => "9c920ed141047eecc73cfa960fe6ce206a16b6c7590e38e53facf45d0941e3a8",
        "darwin_amd64" => "89fa806b6b71e7a699e19e5df1baba56c99a9ec6eae2fbb478432ea4ca620e78",
        "linux_arm64"  => "5d0c0737fbfb66772952ff13e5f879bf0c2193f668ced305075339722a91c6e6",
        "linux_amd64"  => "570609555afa01c6f77f6b6ce1af7bab8ebb77bc2f5a343a703f6c3554535961",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]

        bin.install_symlink Dir[libexec/"bin/*"]


        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
