class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20231011"
    checksums = {
        "darwin_arm64" => "0e45da7cdee74e6381a13a6b1ccc94267571d3f50b21f206d61e299532b874a7",
        "darwin_amd64" => "4ffa401173b4068c1b75d1029156b7fac835c63666d7b4dddd6d19967713920b",
        "linux_arm64"  => "9d01566e3f652d8fdf588441768999e12d57772b75af705f42fcb47a71b5aeef",
        "linux_amd64"  => "0a72ea3857f4953f2230f9a08421568058f6e60b8bff7ed39e03afe88696c983",
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
