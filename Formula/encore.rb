class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.48.2"
    checksums = {
        "darwin_arm64" => "df1b201ebebb6ddf64695a69f503fc4f8b62e12ee78ef7e8192f86fd30001c38",
        "darwin_amd64" => "a4a1fe13891a69dec0d9b1189a2fcb335bb01251f3aabf4543a2eb3f9b7f816d",
        "linux_arm64"  => "6c976ecac45e733cd975d59f0abbd40f363609e99f7d29fe91a1cd51fd36ce6c",
        "linux_amd64"  => "81a453aef03eede5b44fc858fb4fe179dab73371904d0539e4dcc9d92acba4e5",
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
