class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.27.4"
    checksums = {
        "darwin_arm64" => "b3a44d95d80a652bdf5f46b45295019cfa701b25e327d637d81d0ab95b2c517b",
        "darwin_amd64" => "f7f6a56441f6ad2a7dfc7c65da7321650f7ed275b6ee480894c646e26fd8b483",
        "linux_arm64"  => "6a9c2d1a455e5963ba0f5f256e1f780babb3c6fdeb466bdf9a676f575e12ef07",
        "linux_amd64"  => "95594156c8e79bf02972d7992fa957dad2e12c16e4f90badb9fab15265d32f74",
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
