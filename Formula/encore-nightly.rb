class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230817"
    checksums = {
        "darwin_arm64" => "32d607f85b615de540d5ebdf43c477d7c1f439dce85cccb2e28f5f30ce94c8f3",
        "darwin_amd64" => "ce21f1bdb5cf1579061fe61f117980ae5b2e1370f022d0c2baabccc2d4ea2a1d",
        "linux_arm64"  => "029996fff893ff360c5a5975ed3e932f72b258b32c764f39135d634fb7353f54",
        "linux_amd64"  => "cba085926ddbeffa021238c25c223a7b7487225c052ed0ed3b7189562b7dc6d8",
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
