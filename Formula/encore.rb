class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.44.9"
    checksums = {
        "darwin_arm64" => "b81412f259758fc504557bbf49e764257ceb517a9966045e26ca7b1f83acd5b1",
        "darwin_amd64" => "5818bac025f42e3dca344c886bf6b94c0a180a99a5daabb0e3aa5d79682cea8d",
        "linux_arm64"  => "a22874b08fd1487a6c812baf030433d1ecc9117e3ef90880c90e503fa7375934",
        "linux_amd64"  => "12050be2823be613416024d3d8f1cae21aa0a762d7a3ad36dd984a766098b09b",
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
