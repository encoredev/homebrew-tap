class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.51.6"
    checksums = {
        "darwin_arm64" => "dc334661b500d15b3d5ceef5d7278ddb71c93be7e19731948a5dbf07c4db8625",
        "darwin_amd64" => "f2aa6778078390e2fa1d4658c274bf412783c622a34e0bdd7f017ae83ab0f65d",
        "linux_arm64"  => "c8eb731743eadbdb65990e19f7a486d09e5fbef4a92766e4d9909a4913fd0b32",
        "linux_amd64"  => "1e2ebb443b8204fae23ac8ed4f45039835b7b081774539f22a0a715f3ae2567f",
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
