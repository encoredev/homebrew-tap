class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.47.3"
    checksums = {
        "darwin_arm64" => "cd532c3db50504e2e569fe523464c4e7fe0e2ff4032bb527ddc89649f25d3d44",
        "darwin_amd64" => "754140ef9c22fd626a27ecf712f5f6b7db4bf33be916a0d713594c6afd8918ed",
        "linux_arm64"  => "805cf4e88c53cce5f5b206e6babc4ca51cef40d872ca08360a51240b22c26e3f",
        "linux_amd64"  => "edfba5b2501a0cd6e03d3bcf924f4448fb8bba3f717fe1d9dc52ce81337757e9",
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
